#!/bin/bash 
rm -Rf exp.html
echo "<a name=experimental ></a><h1>PICSimLab Examples (Experimental)</h1>" >> exp.html 
echo "<br><h2>Boards:</h2>" >> exp.html 
for board in `find * -maxdepth 0 -type d 2> /dev/null`
do
echo "<br><a href="#$board">$board</a>" >> exp.html 
done
echo "<br><a href=\"#parts_\">Examples by parts</a><br>" >> exp.html 
echo "<br><a href=\"examples_index.html\">Stable boards examples</a><br><br>" >> exp.html 
for board in `find * -maxdepth 0 -type d 2> /dev/null`
do
  cd $board	
  echo "board: $board"	
  mkdir -p "../../help/$board/"
  echo "<hr><a name="$board"></a> <h1><br>Examples: $board</h1>" >> ../exp.html 
  for proc in `find * -maxdepth 0 -type d,l 2> /dev/null`
  do
    cd $proc	
    for name in `find * -maxdepth 0 -type d 2> /dev/null`
    do
      echo "<br><a href=\"#${board}_${proc}_${name}\">$proc/$name</a>" >> ../../exp.html 
    done	    
    cd ..
  done	  
  for proc in `find * -maxdepth 0 -type d,l 2> /dev/null`
  do
    cd $proc	
    echo "board: $board  proc: $proc"	
    echo -n "<a name=\"$board" >> ../../exp.html 
    echo -n "_" >> ../../exp.html 
    echo "$proc\"></a>" >>  ../../exp.html 
    for name in `find * -maxdepth 0 -type d 2> /dev/null`
    do
      echo "board: $board  proc: $proc  directory: $name"	
      mkdir -p "../../../help/$board/$proc/$name/"
      html=`sed -n '/<body/,/<\/body>/{//!p}' $name/Readme.html`
      cp -R "$name/Readme.html" "../../../help/$board/$proc/$name/" 
      cp -R "$name/src/" "../../../help/$board/$proc/$name/"
      cp -R "$name/$name.png" "../../../help/$board/$proc/$name/"
      echo "<hr><table style=\"width:100%\" border=\"0\">" >>  ../../exp.html
      echo "<tr><td colspan=4><a name=\"${board}_${proc}_${name}\"></a><div style=\"color:gray;\"><small>[$board/$proc/$name]</small></div>${html}<br><br></td></tr><tr><td width=\"15%\"><a target=\"blank_\" href=\"$board/$proc/$name/$name.png\"><img src='$board/$proc/$name/$name.png' width=200></a></td>" >> ../../exp.html 
      echo "<td width=\"20%\"><a href=\"../pzw/$board/$proc/$name.pzw\" target=\"_blank\" >Download (pzw)</a></td>" >> ../../exp.html 
      echo "<td width=\"20%\">" >> ../../exp.html
      if [ ! -f "${name}/no_online" ]; then
         echo "<a href=\"../../js_exp/picsimlab.html?../picsimlab_examples/pzw_exp/$board/$proc/$name.pzw\" target=\"_blank\" >Online (wasm)</a><br>" >> ../../exp.html 
         echo "<a href=\"../../js_exp/picsimlab_mt.html?../picsimlab_examples/pzw_exp/$board/$proc/$name.pzw\" target=\"_blank\" >Online (wasm mt)</a><br>" >> ../../exp.html 
         echo "<a href=\"../../js_exp/picsimlab_asmjs.html?../picsimlab_examples/pzw_exp/$board/$proc/$name.pzw\" target=\"_blank\" >Online (asm.js)</a>" >> ../../exp.html
      fi
      echo "</td></tr></table>" >> ../../exp.html 
    done
    cd ..
  done
  cd ..
done
./parts.sh >> exp.html
