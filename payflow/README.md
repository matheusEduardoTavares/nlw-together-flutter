<h2 align="center">
  PayFlow - NLW-Together
</h2>

<br/>

<h3 align="center">
  <a href="https://dart.dev/">
    <img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">
  </a>
  <a href="https://flutter.dev/">
    <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
  </a>
  <a href="https://firebase.google.com">
    <img alt="Firebase" src="https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black">
  </a>
</h3>

---

## 📃 Sobre

**PayFlow** é um projeto mobile desenvolvido com Flutter durante a **NLW-Together**, de muito aprendizado e mão na massa, em que cada dia foi sendo desenvolvido uma parte da aplicação.

O **objetivo** do projeto é que a pessoa possa gerenciar seus próprios boletos bancários, sendo possível fazer login social na aplicação, e uma vez logado, adicionar novos boletos, e ver também as faturas. Além de contar também com animações, é possível fazer a leitura de códigos de barra e a partir disto criar um novo boleto.

## 🚀 Tecnologias e recursos utilizados

Este projeto foi desenvolvido com as seguintes tecnologias:
- [**Visual Studio Code**](https://code.visualstudio.com/): um editor de código-fonte desenvolvido pela Microsoft, que é multiplataforma e muito utilizado;
- [**Dart**](https://dart.dev/): Linguagem de programação;
- [**Flutter**](https://flutter.dev/): Uma UI Toolkit que traz várias facilidades para desenvolvimento Cross-Platform;
- [**Firebase**](https://firebase.google.com): Trata-se de um “SAAS”, que é um software como serviço, ou seja; é uma ferramenta que disponibiliza vários serviços online, de forma que ao fazer uso deste não é necessário se preocupar em criar um “back-end” e toda infraestrutura por traz do modelo de negócio necessário para a aplicação, pois ele já traz diversas facilidades e possui uma gama muito grande de serviços que podem ser utilizados.

## 🔧 Instalação e execução

Para você poder instalar e executar esta aplicação, será preciso ter instalado o git para clonar este repositório, ter a SKD do Flutter instalada na máquina para poder executar o projeto, e por fim ter um projeto criado no Firebase, possuindo uma aplicação Android associada.
<br />
Tendo isto, primeiramente, deve-se filtrar no projeto inteiro e atualizar o identificador da aplicação, para que fique de acordo com o identificador da aplicação cadastrada em seu projeto no Firebase. Pode-se encontrar este identificador em `/android/app/build.gradle`, sendo este o valor da variável `applicationId`. É necessário adaptar este identificador em vários locais, como no próprio `build.gradle`, no `AndroidManifest.xml` dos builds (debug, profile e main), no `MainActivity.kt`, e caso faça uso do iOS, é preciso alterar no `project.pbxproj`.
<br />
Por fim, é só baixar o `google-services.json` da aplicação Android associada ao projeto do Firebase, e adicioná-lo no projeto, ficando com o seguinte caminho: `android/app/google-services.json`. **Lembre-se de nunca subir em repositórios o arquivo `google-services.json`**.
<br />
Pronto, já é possível buildar o APP.

## 📲 Contato

Entre em contato comigo por e-mail ou pelo meu LinkedIn:

<a href="mailto:matheuseduardotavaresdev@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Gmail"/></a>
<a href="https://www.linkedin.com/in/matheus-eduardo-tavares-268589184/"><img src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
***

## ⭐ Atualizações feitas após finalização do evento

1. Features:
    1. Melhorado a UX dos `TextFormField`;
    2. Adicionado `Drawer`;
    3. Adicionado página de configurações;
    4. Adicionado troca de tema entre DARK / LIGHT;
    5. Persistido no `SharedPreferences` o tema;
    6. Adicionado o Provider para gerenciamento do tema;
    7. Adicionado loader para o botão de cadastrar um novo boleto (devido os ajustes feitos estava levando um segundo mais ou menos para finalizar o processo, melhorando, portanto, a UX para o usuário);
    8. Criado os Widgets `LogoutButton` e `LoadingButton`;
    9. Adicionado logout, usando o método da biblioteca do `google_sign_in` para o logout e também limpado os dados do `SharedPreferences`;
    10. Adicionado modal de falha com animação (usando `showGeneralDialog`) no caso de erro ao tentar fazer logout;
    11. Adicionado animação com o `AnimatedCard` na página de configurações;
    12. Adicionado opções de ordenar os extratos pela data de vencimento ou pelo valor;
    13. Criado um enum de opções para essa questão de ordenação;
    14. Criado extension para padronizar e facilitar a ordenação de `List<BoletoModel>`;
    15. Adicionado o campo UUID (usando package uuid) na criação do `BoletoModel` para facilitar o controle interno da entidade;
    16. Adicionado uma validação mais coerente para a data de vencimento;
    17. Mostrado na tela de extratos somente os boletos pagos;
    18. Mostrado mensagem de aviso quando não há boleto pago;
    19. Criado campo no `BoletoModel` que define se o boleto já foi pago ou não;
    20. Criado funcionalidade de setar um boleto como pago ou não pago;
    21. Passado toda lógica do boleto para uso do `Provider`, afim de garantir as atualizações da view de forma correta;
    22. Deixado a página de extrato apenas para boletos pagos e com opção de ordenação, e deixado a página dos boletos em si com todos os boletos e mostrando a contagem somente dos não pagos;
    23. Feito uso do `showModalBottomSheet` para componente onde é possível setar boleto como pago ou não pago, e também deletar um boleto;
    24. Adicionado funcionalidade de excluir boletos;
2. Bugfixes:  
    1. Atualizado os boletos automaticamente ao criar um novo;

---

<h5 align="center">
  &copy;2021 - <a href="https://github.com/matheusEduardoTavares">Matheus Eduardo Tavares</a>
</h5>