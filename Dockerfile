FROM alpine

RUN apk update
RUN apk add bash nodejs npm curl
WORKDIR /dotfiles
COPY ./ ./
RUN ./install.sh
CMD ["tmux", "-l"]