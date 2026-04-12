FROM racket/racket:9.1-full

RUN mkdir Maze/

COPY . Maze/

WORKDIR Maze/

CMD ["./run_unit_tests.sh"]
