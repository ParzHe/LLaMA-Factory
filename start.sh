#!/bin/bash

cd LLaMA-Factory

export GRADIO_TEMP_DIR="../fssd/tmp/"
export HUGGINGFACE_HUB_CACHE="../fssd/HF_cache"
export HF_HOME="../fssd/HF"

export HF_HUB_ENABLE_HF_TRANSFER=1

file="../fssd/HF/token"

# 检查文件是否存在
if [ -f "$file" ] 
then
    llamafactory-cli webui && cd ..
else
    huggingface-cli login && llamafactory-cli webui && cd ..
fi