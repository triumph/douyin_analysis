# 从官方 Python 基础镜像开始
FROM dokken/centos-stream-9:latest

# 将当前工作目录设置为 /code
# 这是放置 requirements.txt 文件和应用程序目录的地方
WORKDIR /root

RUN mkdir douyin_analysis

# 复制 requirements.txt 文件
# 由于这个文件不经常更改，Docker 会检测它并在这一步使用缓存，也为下一步启用缓存
COPY ./requirements.txt /root/requirements.txt

COPY ./google_chrome.repo /etc/yum.repos.d/

RUN yum install -y google-chrome-stable
RUN yum install -y python3.11

# 运行 pip 命令安装依赖项
RUN pip3 install --no-cache-dir --upgrade -r /root/requirements.txt

# 复制 FastAPI 项目代码
COPY ./CODES /root/douyin_analysis/CODES

# 运行服务
ENTRYPOINT python3 /root/douyin_analysis/CODES/main.py