FROM ubuntu:24.04 AS builder

RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    git \
    make \
    cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/ReaderLM-v2-Q8_0.gguf \
    https://huggingface.co/rbehzadan/ReaderLM-v2.gguf/resolve/main/ReaderLM-v2-Q8_0.gguf?download=true

RUN git clone https://github.com/ggerganov/llama.cpp.git /llama.cpp

WORKDIR /llama.cpp
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc)

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y \
    libgomp1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /llama.cpp/build/bin/llama-server /usr/local/bin/llama-server
COPY --from=builder /llama.cpp/build/bin/*.so /usr/local/lib
RUN ldconfig && mkdir -p /models
COPY --from=builder /tmp/ReaderLM-v2-Q8_0.gguf /models

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/llama-server", "--host", "0.0.0.0"]
CMD ["--model", "/models/ReaderLM-v2-Q8_0.gguf"]
