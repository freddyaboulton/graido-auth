# FROM python:3.8


# # Default Debian packages
# # RUN apt-get update && apt-get install -y \
# #         ffmpeg \
# #         libsm6 \
# #         libxext6 \
# #         cmake \
# #         libgl1-mesa-glx

# # User
# RUN useradd -m -u 1000 user
# USER user
# ENV HOME /home/user
# ENV PATH $HOME/.local/bin:$PATH
# WORKDIR $HOME
# RUN mkdir app
# WORKDIR $HOME/app

# # Python packages
# ARG PIP_VERSION=22.0.2
# RUN pip install pip==${PIP_VERSION}
# RUN pip install \
#         datasets \
#         huggingface-hub
# COPY requirements.txt $HOME/app/requirements.txt
# RUN pip install -r requirements.txt

# RUN pip install gradio

# # App
# COPY --chown=user --from=lfs /app $HOME/app
# COPY --chown=user ./ $HOME/app
# ENV PYTHONPATH $HOME/app
# ENV PYTHONUNBUFFERED 1
# ENV GRADIO_ALLOW_FLAGGING never
# ENV GRADIO_NUM_PORTS 1
# ENV GRADIO_SERVER_NAME 0.0.0.0
# ENV GRADIO_THEME huggingface
# ENV SYSTEM spaces
# RUN python app.py

FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV GRADIO_ALLOW_FLAGGING never
ENV GRADIO_NUM_PORTS 1
ENV GRADIO_SERVER_NAME 0.0.0.0
ENV GRADIO_PORT 80
ENV GRADIO_THEME huggingface

CMD [ "python", "app.py" ]