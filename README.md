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
