### repoクローン方法
git clone --recurse-submodules git@github.com:c0b220090b/anime_repo.git

### repo関係
repo/                  ← 新しく.gitを作る（Dockerfileなどを管理）
├── .git
├── Dockerfile
├── docker-compose.yml
└── comfy/              ← 既に.gitがある（ComfyUI_repo）
    └── .git

### docker関係
docker build -t comfyui-custom:latest .
docker-compose up -d

### ComfyUI-Managerのインストール
cd /comfyui/custom_nodes
git clone https://github.com/Comfy-Org/ComfyUI-Manager.git comfyui-manager
rm -rf comfyui-manager/.git
