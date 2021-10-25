# FREELANCERS - aplicação web

<p align="end">Outubro de 2021</p>

**Projeto final TreinaDev Turma 7 - projeto de plataforma para contratação de freelancers.**

## Descrição

A aplicação oferece o serviço de contratação de freelancers para trabalhos de programação. Os usuários contratantes podem se cadastrar no site e submeter projetos para serem vistos pelo público. Os profissionais freelancers podem se cadastrar no site para enviar propostas para executar os projetos. No final, o contratante encerra o projeto e ambas as partes podem enviar feedbacks um sobre o outro.

<img src="https://github.com/MauroImamura/teste02/blob/main/freelancer-homepage.jpg"/>

## Requisitos

* ruby version 3.0.0
* rails version 6.1.4.1

## Instalação

* Baixe o repositório completo da aplicação:

        git clone https://github.com/MauroImamura/TD7_freelancers.git

* abra o diretório:

        cd TD7_freelancers

* faça a instalação das dependências necessárias:

        bin/setup

## Testes

A aplicação foi desenvolvida por meio de testes automatizados (TDD) com os recursos rspec e capybara. Para executá-los, execute o comando:

    rspec

Após seguir os passos de instalação apresentados anteriormente, todos os testes devem estar passando.

Você pode ver detalhadamente os cenários de teste no diretório TD7_freelancers/rspec

## Navegue pela aplicação

Para utilizar a aplicação em modo desenvolvimento, já existem instâncias na seed da aplicação para popular o banco de dados:

    rails db:seed

Com isso, é possível ver detalhes dos projetos e profissionais já cadastrados no sistema, além de poder logar com os perfis disponíveis:

### Contratantes:
   * email: abraao@freelancers.com.br // senha: 123456
   * email: isaac@freelancers.com.br // senha: 123456
   * email: jaco@freelancers.com.br // senha: 123456

### Freelancers:
   * email: davi@freelancers.com.br // senha: 123456
   * email: moises@freelancers.com.br // senha: 123456 
   * email: aarao@freelancers.com.br // senha: 123456

Esta aplicação se encontra no repositório https://github.com/MauroImamura/TD7_freelancers e está sujeita a alterações futuras.