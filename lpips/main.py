import lpips


loss_fn = lpips.LPIPS(net="alex").cuda()

img0 = lpips.im2tensor(lpips.load_image("test_orig.png")).cuda()
img1 = lpips.im2tensor(lpips.load_image("test_q8.png")).cuda()
d = loss_fn(img0, img1)
