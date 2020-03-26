FROM alpine

RUN apk update
RUN apk add bash nodejs npm curl
WORKDIR /dotfiles
COPY ./ ./
RUN ./install.sh
RUN set t_Co=256\
colorscheme codedark
CMD ["tmux", "-l"]