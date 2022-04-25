
[ ! -d "./gromacs_generated_files" ] && mkdir gromacs_generated_files
cd gromacs_generated_files
wget https://www.ic.unicamp.br/~edson/disciplinas/mo833/2021-1s/anexos/6LVN.pdb
wget https://www.ic.unicamp.br/~edson/disciplinas/mo833/2021-1s/anexos/ions.mdp

alias gmx="docker run — privileged -it --user=$(id -u):$(id -g) -v ${PWD}:${PWD} -w ${PWD} --rm gromacs_exp:release perf record gmx"
gmx pdb2gmx -f 6LVN.pdb -o 6LVN_processed.gro -water spce
gmx editconf -f 6LVN_processed.gro -o 6LVN_newbox.gro -c -d 1.0 -bt cubic
gmx solvate -cp 6LVN_newbox.gro -cs spc216.gro -o 6LVN_solv.gro -p topol.top

gmx grompp -f ions.mdp -c 6LVN_solv.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o 6LVN_solv_ions.gro -p topol.top -pname NA -nname CL -neutral
gmx grompp -f ions.mdp -c 6LVN_solv_ions.gro -p topol.top -o em.tpr