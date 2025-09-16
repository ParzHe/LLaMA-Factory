#!/bin/bash

cd /home/tom/

mkdir -p fsas/LLaMA-Factory/config

cd LLaMA-Factory

enable_modelscope=$1
modelscope_credentials="../.modelscope/credentials"

export GRADIO_TEMP_DIR="../fssd/tmp/"
export HUGGINGFACE_HUB_CACHE="../fssd/HF_cache"
export MODELSCOPE_CACHE="../fssd/MS_cache"
export MODELSCOPE_MODULES_CACHE='../fssd/MS_cache/modelscope_modules'
export HF_HOME="../fssd/HF"


if [ $enable_modelscope == 1 ]
then
    export USE_MODELSCOPE_HUB=1
    
    if [ -e "$modelscope_credentials" ]
    then
        llamafactory-cli webui && cd ..
    else
        echo "下载私有模型需要在终端输入 \"modelscope login --token <YOUR_MODELSCOPE_SDK_TOKEN>\" 设置魔塔社区 SDK 令牌。（登录魔塔社区ModelScope-点击右上角头像-账号设置-访问令牌 即可查询）"
        llamafactory-cli webui && cd ..
    fi
else
    export HF_HUB_ENABLE_HF_TRANSFER=1
    file="../fssd/HF/token"
    if [ -f "$file" ] 
    then
        llamafactory-cli webui && cd ..
    else
        huggingface-cli login && llamafactory-cli webui && cd ..
    fi
fi
