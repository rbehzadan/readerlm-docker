# ReaderLM Markdown Converter (Dockerized)

![Docker Build](https://github.com/rbehzadan/readerlm-docker/actions/workflows/build-and-push-native.yaml/badge.svg)

This project provides a **Dockerized API service** for converting HTML to Markdown using **ReaderLM-v2**, a specialized LLM for document processing. It leverages `llama.cpp` to efficiently run the model and serve responses via an **OpenAI-compatible API**.

## 🚀 Features
- **Runs ReaderLM-v2 in a lightweight container**
- **Compatible with OpenAI API format**
- **No dependencies needed—just `docker run`!**
- **Optimized for CPU-based inference**

## 📦 Docker Image
The pre-built image is available on [Docker Hub](https://hub.docker.com/r/rbehzadan/readerlm).

### **Pull the latest image**
```sh
docker pull rbehzadan/readerlm:latest
```

---

## 🛠️ Running the Server

### **1. Start the API server**
```sh
docker run -d --name readerlm-server -p 8080:8080 rbehzadan/readerlm:latest
```
This launches the model server at `http://localhost:8080`.

### **2. Convert HTML to Markdown (via API)**
Use `curl`, `httpie`, or Python to send a request:

#### **Example Request (Python)**
```python
import requests

messages = [
    {"role": "system", "content": "Convert the HTML to Markdown."},
    {"role": "user", "content": "<html><body><h1>Hello, world!</h1><p>This is a test!</p></body></html>"}
]

response = requests.post("http://localhost:8080/v1/chat/completions", json={"messages": messages, "temperature": 0.1})
markdown_output = response.json()["choices"][0]["message"]["content"].strip()

print(markdown_output)
```

#### **Expected Output**
```markdown
Hello, world!
-------------

This is a test!
```

---

## 🛠️ Building the Image Locally
If you prefer to build the Docker image manually, use:

```sh
docker build -t readerlm:local .
```

Run the container:

```sh
docker run -p 8080:8080 readerlm:local
```

---

## 📝 Model & License Information
- **Model**: [ReaderLM-v2](https://huggingface.co/jinaai/ReaderLM-v2)
- **Quantized Format**: GGUF (via `llama.cpp`)
- **License**: [CC-BY-NC-4.0](https://huggingface.co/rbehzadan/ReaderLM-v2.gguf)

---

## 🤝 Contributing
Contributions are welcome! To contribute:
1. Fork the repository
2. Create a new branch (`feature-xyz`)
3. Commit your changes
4. Open a **Pull Request**

---

## 📬 Contact & Support
If you have any issues or questions, feel free to **open an issue** or reach out via [GitHub Discussions](https://github.com/rbehzadan/readerlm/discussions).

Happy Coding! 🚀

