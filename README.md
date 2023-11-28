# IFSP Inventariado

O objetivo com esse programa era facilitar o processo de registrar o inventario do IFSP campus Salto, de tal maneira, os integrantes decidiram por criar uma aplicação em Flutter no Frontend e python no Backend, sendo possível acessar neste [link](https://github.com/GabrielFS1/inventario_server). Esse projeto foi realizado como prática de aula de PJI, além de ser apresentado no IFCiência.

## Como Compilar

Para a compilação do código, deve se instalar o [Flutter seguindo os passos da documentação](https://docs.flutter.dev/get-started/install).

Após a instalação deve se realizar a clonagem do repositório:
```
    git clone https://github.com/MatheusBorelli/IFSP_inventariado.git
```

Para garantir que as dependências estejam no Projeto é necessario executar o seguinte comando no diretório:
```
    flutter pub get
```
Para funcionamento correto da aplicação deve se criar um arquivo **.env** na raíz do projeto, dentro dele deve se ter a chave **API_URL**, a qual será responsável por ser a URL base para o contato com o server. O arquivo **.env** deverá ficar como no exemplo:
```
    API_URL=https://url-da-api/
```

Por fim podemos executar o seguinte comando para fazer a build de um apk do projeto:
```
    flutter build apk
```
Ou caso queira rodar no emulador ou no próprio Smartphone Android(Que deve estar no modo de Depuração USB ativado):
```
    flutter run
```