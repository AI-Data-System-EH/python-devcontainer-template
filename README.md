# Devcontainer로 개발환경 사용하기

- 필요한 모든 종속성이 포함된 개발 환경을 빠르게 설정
- 일관되고 재현 가능한 개발 환경 공유
- 로컬 환경과 격리된 컨테이너로 종속성 충돌 및 불필요한 설치 방지

<br/>

# 템플릿 리포지토리 사용방법

> 자세한 설명은 "[템플릿에서 리포지토리 만들기](https://docs.github.com/ko/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)" 링크를 참조하세요.

## Web에서 리포지토리 생성

오른쪽 위 `Use this template` 버튼을 눌러 새 리포지토리를 생성하세요.

## GitHub CLI로 내 GitHub 프로필에 새 리포지토리 생성

> `your-project-name`을 새로 생성할 리포지토리 이름으로 변경하세요.

```bash
gh repo create --template https://github.com/AI-Data-System-EH/python-devcontainer-template --public your-repository-name
```

## Git으로 로컬에 리포지토리 클론

> `your-repository-name`을 새로 생성할 리포지토리 이름으로 변경하세요.

```bash
git clone https://github.com/AI-Data-System-EH/python-devcontainer-template your-repository-name
```

<br/>

# Visual Studio Code에서 Devcontainer 프로젝트 열기

1. [Docker Desktop](https://www.docker.com/products/docker-desktop)(또는 [Docker CLI](https://docs.docker.com/engine/install/ubuntu/))를 설치합니다.
2. [Visual Studio Code](https://code.visualstudio.com/)을 설치합니다.
3. Visual Studio Code에 [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 확장을 설치합니다.
4. Visual Studio Code에서 `파일 > 폴더 열기...`를 선택하여 프로젝트를 엽니다.
5. Visual Studio Code에서 `F1`을 눌러 `개발 컨테이너: 컨테이너에서 폴더 열기 (Dev Containers: Open Folder in Container)`를 선택합니다.
   > :warning: 프로젝트 폴더에 `.devcontainer/devcontainer.json` 파일이 있어야 vscode에서 devcontainer를 사용할 수 있습니다.
6. 개발 컨테이너가 준비되면 프로젝트를 사용할 수 있습니다.
