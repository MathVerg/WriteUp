# docker build -t electric . && docker run -t electric
FROM python:3.11.6

RUN pip install --no-cache-dir Cython
COPY script.cpython-311-x86_64-linux-gnu.so /script.cpython-311-x86_64-linux-gnu.so
COPY justpython.py /justpython.py
CMD ["python", "-i", "justpython.py"]
