# morshd

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## setup 

bash```
git clone 
cd ChatAPP_AI_solution
```
install the requierments 

bash```
pip install -r requirements.txt
```


download ollama for windows

url```

```

then verfy the instlation 

bash```
ollama --verstion
```

if you see verstion that mean she is installed if not add bin path of it to windows enviorments varibles and check again

then pull the requiered model 

bash```
ollama pull llama3.1:8b
```

then run this to start fast api endpoints 
bash```
uvicorn main:app --reload --port 4000
```

if you see any module error like module not found for example fastapi run this for each module 

bash ```
pip install module_name #for example fast api 
```

then access localhost:4000/docs for api docemntation

and you have txt file called api_test_curls.txt he have postman test cases for each case 

