abraao_avinu = User.create!(email: 'abraao@freelancers.com.br', password: '123456')
isaac_avinu = User.create!(email: 'isaac@freelancers.com.br', password: '123456')
jaco_avinu = User.create!(email: 'jaco@freelancers.com.br', password: '123456')
moises_levi= Worker.create!(email: 'moises@freelancers.com.br', password: '123456', full_name: 'Moises Levi',
                                    social_name: 'Moises Levi', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails',
                                    birth_date: '10/10/1010'
                                    )
aarao_levi= Worker.create!(email: 'aarao@freelancers.com.br', password: '123456', full_name: 'Aarao Levi',
                                    social_name: 'Aarao Levi', description: 'web developer', education: 'técnico',
                                    experience: '3 anos de experiência na empresa Bamidbar',
                                    birth_date: '11/11/1111'
                                    )
davi_juda= Worker.create!(email: 'davi@freelancers.com.br', password: '123456', full_name: 'Davi Juda',
                                    social_name: 'Davi Juda', description: 'desenvolvedor apps mobile', education: 'técnico',
                                    experience: '2 aplicativos lançados',
                                    birth_date: '12/12/1212'
                                    )
job1 = Job.create!(title: 'Site de locação de imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 30, deadline: '15/11/2021', user: abraao_avinu, status: 10)
job2 = Job.create!(title: 'Site de locação de veículos',
                                    description: 'Criar uma aplicação em que os usuários cadastram seus veículos e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 35, deadline: '16/11/2021', user: abraao_avinu, status: 30)
job3 = Job.create!(title: 'Site de reviews de livros',
                                    description: 'Criar uma aplicação em que os usuários submetem opiniões sobre livros',
                                    skills: 'Django, aplicação em pt-BR, EN e ESP.',
                                    payment: 25, deadline: '17/11/2021', user: isaac_avinu, status: 10)
job4 = Job.create!(title: 'Site de imagens',
                                    description: 'Criar uma aplicação em que os usuários criam seu banco de imagens para acesso e compartilhamento',
                                    skills: 'Django, aplicação em pt-BR, EN e ESP.',
                                    payment: 32, deadline: '18/11/2021', user: isaac_avinu, status: 10)
job5 = Job.create!(title: 'Site de curiosidades',
                                    description: 'Criar uma aplicação para postagem de artigos semanais sobre curiosidades.',
                                    skills: 'Front-end: html, css, javascript',
                                    payment: 18, deadline: '19/11/2021', user: jaco_avinu, status: 20)
job6 = Job.create!(title: 'Site de grupos de estudos',
                                    description: 'Criar uma aplicação onde os usuários encontram pessoas para organizarem grupos de estudos.',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 28, deadline: '20/11/2021', user: jaco_avinu, status: 10)
appl1 = Application.create!(description: 'Projetos ruby on rails', payment: 35, time_per_week: 8,
                                    expected_deadline: '10/11/2021', worker: moises_levi, job: job1, status: 10)
appl2 = Application.create!(description: 'Projetos ruby on rails', payment: 33, time_per_week: 8,
                                    expected_deadline: '11/11/2021', worker: aarao_levi, job: job1, status: 10)
appl3 = Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                                    expected_deadline: '12/11/2021', worker: moises_levi, job: job2, status: 10)
appl4 = Application.create!(description: 'Projetos ruby on rails', payment: 28, time_per_week: 8,
                                    expected_deadline: '12/11/2021', worker: davi_juda, job: job2, status: 10)
appl5 = Application.create!(description: 'Projetos ruby on rails', payment: 29, time_per_week: 8,
                                    expected_deadline: '09/11/2021', worker: davi_juda, job: job3, status: 10)
appl6 = Application.create!(description: 'Projetos ruby on rails', payment: 29, time_per_week: 8,
                                    expected_deadline: '11/11/2021', worker: aarao_levi, job: job3, status: 10)
appl7 = Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                                    expected_deadline: '10/11/2021', worker: moises_levi, job: job4, status: 10)
appl8 = Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                                    expected_deadline: '08/11/2021', worker: moises_levi, job: job5, status: 10)
appl9 = Application.create!(description: 'Projetos ruby on rails', payment: 22, time_per_week: 8,
                                    expected_deadline: '15/11/2021', worker: davi_juda, job: job5, status: 0)
appl10 = Application.create!(description: 'Projetos ruby on rails', payment: 22, time_per_week: 8,
                                    expected_deadline: '12/11/2021', worker: aarao_levi, job: job5, status: 10)
appl11 = Application.create!(description: 'Projetos ruby on rails', payment: 23, time_per_week: 8,
                                    expected_deadline: '13/11/2021', worker: davi_juda, job: job6, status: 5)
appl12 = Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                                    expected_deadline: '10/11/2021', worker: moises_levi, job: job6, status: 10)
favorited_worker1 = FavoritedWorker.create!(user: abraao_avinu, worker: davi_juda, checked: true)
favorited_worker2 = FavoritedWorker.create!(user: jaco_avinu, worker: moises_levi, checked: true)
favorited_worker3 = FavoritedWorker.create!(user: jaco_avinu, worker: aarao_levi, checked: true)
worker_feedback1 = WorkerFeedback.create!(user: abraao_avinu, worker: moises_levi, application: appl3, rate: 4, comment: 'Boa comunicação, entrega tarefas com antecedência')
worker_feedback2 = WorkerFeedback.create!(user: abraao_avinu, worker: davi_juda, application: appl4, rate: 4, comment: 'Bom conhecimento técnico')
user_feedback1 = UserFeedback.create!(user: abraao_avinu, worker: davi_juda, job: job2, rate: 5, comment: 'Comunicação clara, pagamento em dia')
user_feedback2 = UserFeedback.create!(user: abraao_avinu, worker: moises_levi, job: job2, rate: 4, comment: 'Boa organização e planejamento')