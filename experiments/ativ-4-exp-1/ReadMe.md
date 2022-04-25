# Instruções para realização do experimento

## construir imagens

Para construir as imagens, utilize o dockerfile que esta na raiz do repositorio, cada imagem deve demorar cerca de 20 minutos para ser construida. o Dockerfile ja instala as ferramentas de perfilamento.

para imagem de release
```
docker build --build-arg build_type=Release -t gromacs_exp:release .
```
# gerar arquivos necessarios para simulação

Va ate a pasta "experiments/ativ-4-exp-1/"
```
cd experiments/ativ-4-exp-1
```
execute o shell script 'setup_simulation.sh', note que esse script depende que as imagens ja estejam construidas e com o mesmo nome explicitada anteriormente
```
sh setup_simulation.sh
```

Note que os artefatos gerados para realização do experimento original também estão disponiveis em "experiments/ativ-4-exp-1/gromacs_generated_files"

# Executar simulações


Inicie um bash interativo no container
```
docker run -it --privileged --user=$(id -u):$(id -g) -v ${PWD}:${PWD} -w ${PWD} --rm gromacs_exp:release bash
```

## Executar profilamento com perf


execute 
```
perf record gmx mdrun -v deffmn em
```
um arquivo perf.data sera gerado. execute o comando a seguir para ver o relatorio
```
perf report
```

## Executar profilamento com callgrind

execute 
```
valgrind --tool=callgrind gmx mdrun -v deffmn em
```
Um arquivo "callgrind.out.<pid>" vai ser criado, execute o comando a seguir para gerar o relatorio
```
callgrind_annotate callgrind.out.<pid>
```

obs: a execução do callgrind torna a aplicação bem lenta.
