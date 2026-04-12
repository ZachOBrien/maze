FROM racket/racket:9.1-full

RUN mkdir Maze/

COPY . Maze/

WORKDIR Maze/

CMD ["raco", "test", "Maze"]
