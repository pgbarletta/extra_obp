## 22-5-2: NUEVA CORRIDA EXTRA P/ VER SI LOGRO DESARMAR LA C-TERM HELIX
## Copiado de reobp/top_files, salvo alguna pequeña modificación. Puede q no sea exactamente lo q hice
ctv:
----
    saco el ligando a un .pdb: "orig_citralva.pdb"
    le saco hidrógenos
    pdb4amber -i orig_citralva.pdb -o hcitralva.pdb --reduce // elimino todos los archivos generados, salvo hcitralva.pdb
    le remuevo un hidrógeno (1920 H8) unido al carbono nitrílico (C8)
    antechamber -i hcitralva.pdb -fi pdb -o hcitralva.mol2 -fo mol2 -c bcc
    parmchk2 -i hcitralva.mol2 -f mol2 -o hcitralva.frcmod
    Hago el archivo "leap_citralva.in" y lo corro. // Aca solo incluyo a citralva. Lo hago p/ checkear
    copio el ligando entero de "citralva.pdb" y lo uso p/ reemplazar al ligando
        original de "wt_ctv.pdb". // Asi no tengo inconsistencias en el naming.
        Luego le arreglo la numeración a los átomos del ligando y al residuo
        // En realidad copio con visual block, p/ conservar los números de
        // átomos. El resto, conservo del original (nro de residuo y coordenadas)
    Ahora si, escribo y corro "leap_ctv.in"

    vi orig_ctv.pdb // y borré todos los hidrógenos con: %g/          H/d.
        SELECCIONAR ANTES A LA PROTE SIN EL LIGANDO, Q NO ES PROTONABLE Y SUS HIDRÓGENOS YA ESTÁN PUESTOS.
    to_cph.sh orig_wt_ctv.pdb // p/ poner las GL4, AS4 y reemplazar CYS por CYX
    wrote and run "leap_ls.in". logfile in "leap.log"
    cpinutil.py -p pre_ctv.prmtop -resnames AS4 GL4 HIP -o incph_ctv -op ctv.prmtop // "ctv.prmtop" es el topology corregido p/ carboxilatos
    // hago el script `parmed_hmass_script`
    parmed -i parmed_hmass_script

// Agregado  24/9/2020
    // Me dí cuenta de q me faltaba una topología dry_. Así q agrego:
    // tempo_leap_ctv.in // lo corro y obtengo dry_ctv.prmtop, dry_ctv.rst7, re_ctv.prmtop y re_ctv.rst7
    // Los 2 últimos son p/ checkear q obtenga lo mismo q obtuve años atras. Por suerte todo bien,
    // hay algunas diferencias, pero son decimales.

