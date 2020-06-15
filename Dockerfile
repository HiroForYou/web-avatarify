FROM python:3.7

WORKDIR /code

COPY requirements.txt .

RUN pip install torch==1.2.0+cpu torchvision==0.4.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install -r requirements.txt && pip install PyYAML==5.3.1

RUN git clone https://github.com/alievk/first-order-model.git fomm
RUN cd fomm && git checkout efbe0a6f17b38360ff9a446fddfbb3ce5493534c && cd ..

WORKDIR /code
COPY download_model.py .
RUN python download_model.py

COPY app ./app
COPY afy ./afy

CMD uvicorn app.server:app --port $PORT --workers 1 --host 0.0.0.0