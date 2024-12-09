# container-images

Just a collection of Docker/Podman images I personally use.

I need them hosted in a public repo that doesn't require any authentication and so here they are.

Don't expect any semblance of stability or sanity.

Although, outside of my personal use, the ones that might be interesting to others might be:

* `comfyui` Packages up [ComfyUI](https://github.com/comfyanonymous/ComfyUI), relocating all the persistent data (models, caches, configuration, etc.) into a single Docker volume (which you provide).

   Also compatible with custom nodes, even ones that require a `pip install`.

   (I don't use ComfyUI-Manager and I literally only use 5-6 custom node sets. So this works fine for me.)

   I use it regularly on a server in my homelab. I have yet to test it in the cloud.

* `flux-gguf` Builds and packages together the conversion script (plus all of its Python dependencies) and modified `llama-quantize` for [ComfyUI-GGUF](https://github.com/city96/ComfyUI-GGUF).

   Given the size of your typical fp16 Flux.1 safetensors file (22+ GB), I anticipated quantizing finetunes and such in AWS, where memory, bandwidth, and storage was more plentiful than what I had at home.

   I haven't found a finetune that I wanted to try that didn't already have GGUF files though. But I did test this image successfully with Flux.1-Fill (...at home).
