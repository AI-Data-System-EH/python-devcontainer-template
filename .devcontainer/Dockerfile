# Dockerfile for the devcontainer
# Branch: maintain
# Version: 0.1.0
# Tag: alpha

# Install
#   - Python 3.12
#   - Poetry
#   - Oh My Zsh
#   - Pre-commit

FROM python:3.12-bullseye

# User configuration
ARG USER_NAME=user
ARG USER_UID=1000
ARG USER_GID=1000
ARG WORKSPACE=/workspace

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    zsh \
    sudo \
    nano \
    bat \
    locales \
    tzdata

RUN apt-get autoremove -y && apt-get clean

# Set locale
ENV LANG=ko_KR.UTF-8
ENV LC_MESSAGES=POSIX
RUN localedef -i ko_KR -c -f UTF-8 -A /usr/share/locale/locale.alias ko_KR.UTF-8 \
    && update-locale LANG=$LANG LC_MESSAGES=$LC_MESSAGES

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


WORKDIR ${WORKSPACE}

# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser --disabled-password --gecos "" --uid ${USER_UID} ${USER_NAME} \
    && chown -R ${USER_NAME} ${WORKSPACE}

# Grant sudo privilege to ${USER_NAME}
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER_NAME}

# Switch container user to ${USER_NAME}
USER ${USER_NAME}

# Set Zsh as default shell
RUN sudo chsh -s /bin/zsh ${USER_NAME}
# ENV SHELL=/bin/zsh

# Install Oh My Zsh and plugins
ENV ZSH_CUSTOM=/home/${USER_NAME}/.oh-my-zsh/custom
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search \
    && git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k \
    && git clone https://github.com/mattmc3/zsh-safe-rm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-safe-rm \
    && git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat \
    && git clone https://github.com/gretzky/auto-color-ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/auto-color-ls \
    && git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate

# Copy .zshrc and .p10k.zsh
COPY extra/.zshrc /home/${USER_NAME}/.zshrc
COPY extra/.p10k.zsh /home/${USER_NAME}/.p10k.zsh

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install --all --no-fish

# Install Ruby gem for colorls
RUN sudo apt-get -y install --no-install-recommends ruby-dev \
    && sudo gem install colorls

# Install Poetry
ENV POETRY_HOME=/home/${USER_NAME}/.poetry
ENV PATH="${POETRY_HOME}/bin:${PATH}"
RUN curl -sSL https://install.python-poetry.org | python3 -

# Configure Poetry
RUN mkdir -p ${ZSH_CUSTOM}/plugins/poetry \
    && poetry completions zsh > ${ZSH_CUSTOM}/plugins/poetry/_poetry \
    && poetry config virtualenvs.create true \
    && poetry config virtualenvs.in-project true \
    && poetry config virtualenvs.path .venv \
    && poetry self update

# Install pre-commit
RUN pip install pre-commit

# Install pip requirements
# COPY requirements.txt .
# RUN python -m pip install -r requirements.txt

CMD [ "/bin/zsh" ]
