# 1 Instância Individual (Single-AZ):

Essa é a configuração mais simples, onde você tem apenas uma instância do banco de dados em uma única zona de disponibilidade (AZ).
É adequada para cargas de trabalho que podem tolerar um curto período de inatividade em caso de falha de hardware ou manutenção agendada.

# 2 Instância Individual Multi-AZ:

Semelhante à instância individual, mas com uma réplica automática em uma zona de disponibilidade adicional para maior disponibilidade e recuperação de desastres.
Em caso de falha na instância principal, o Amazon RDS promove automaticamente a réplica para ser a principal.

# 3 Configuração de Cluster:

Alguns bancos de dados suportam configurações de cluster, onde vários nós trabalham juntos para melhorar o desempenho e a disponibilidade.
Exemplos incluem o Amazon Aurora, que oferece um cluster de banco de dados com réplicas leituras/gravações distribuídas automaticamente em várias zonas de disponibilidade.

# 4 Configuração Multi-AZ para Cluster:

Alguns clusters oferecem opções Multi-AZ, o que significa que cada nó do cluster pode ser replicado em uma zona de disponibilidade adicional.
Isso aumenta a resiliência do cluster a falhas de hardware ou problemas de disponibilidade em uma única zona.