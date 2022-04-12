# Instruções para realização do experimento

## construir imagens

Para construir as imagens, utilize o dockerfile que esta na raiz do repositorio, cada imagem deve demorar cerca de 20 minutos para ser construida.

para construir a imagem de debug
```
docker build --build-arg build_type=Debug -t gromacs_exp:debug .
```
para imagem de release
```
docker build --build-arg build_type=Release -t gromacs_exp:release .
```
# gerar arquivos necessarios para simulação

Va ate a pasta "experiments/ativ-3-exp-1/"
```
cd experiments/ativ-3-exp-1
```
execute o shell script 'setup_simulation.sh', note que esse script depende que as imagens ja estejam construidas e com o mesmo nome explicitada anteriormente
```
sh setup_simulation.sh
```

Note que os artefatos gerados para realização do experimento original também estão disponiveis em "experiments/ativ-3-exp-1/gromacs_generated_files"

# Executar simulações

Para executar a simulação, va ate a pasta  "experiments/ativ-3-exp-1/ e execute o script "run_experiment.sh", esse script recebe 3 flags
- n : numero de vezes que o experimento deve ser executado
- t : tag da image a ser utilizada
- r : arquivo para o qual mandar o output

comando executado para medir 5 vezes o tempo da imagem de debug
```
sh run_experiment.sh -n 5 -t debug -r debug.txt
```
comando executado para medir 5 vezes o tempo da imagem de release
```
sh run_experiment.sh -n 5 -t release -r release.txt
```
