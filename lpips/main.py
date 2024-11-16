from collections import namedtuple
import os

import lpips
import numpy as np
import PIL.Image
import torch


Output = namedtuple('Output', ['basename', 'difference'])


def load_image(path):
    img = PIL.Image.open(path)
    return np.array(img)


def main(reference_fn: str, images: list[str], cuda: bool=False, spatial_fn: str|None=None):
    loss_fn = lpips.LPIPS(net="alex", spatial=True)
    if cuda:
        loss_fn = loss_fn.cuda()

    reference = lpips.im2tensor(load_image(reference_fn))
    if cuda:
        reference = reference.cuda()

    output = []
    for image_fn in images:
        base = os.path.basename(image_fn)
        base = os.path.splitext(base)[0]

        img = lpips.im2tensor(load_image(image_fn))
        if cuda:
            img = img.cuda()

        d = loss_fn(reference, img)

        d = d.cpu()
        output.append(Output(basename=base, difference=d))

    for basename, difference in output:
        print(f'{basename}: {difference.mean():.3f}')

        if spatial_fn is not None:
            diff_array = (difference * 255.).to(torch.uint8)
            diff_array = diff_array.repeat(1, 3, 1, 1)
            diff_array = diff_array.permute(0, 2, 3, 1)
            diff_img = PIL.Image.fromarray(diff_array.numpy()[0])
            diff_img.save(f'{basename}-{spatial_fn}.png', 'PNG')


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser("Calculate perceptual similarity")

    parser.add_argument('--cuda', action='store_true', help='use CUDA')
    parser.add_argument('--spatial', type=str, default=None, help='prefix for spatial map')
    parser.add_argument('reference', help='reference image')
    parser.add_argument('image', nargs='+', help='test image(s)')

    args = parser.parse_args()

    main(args.reference, args.image, cuda=args.cuda, spatial_fn=args.spatial)
