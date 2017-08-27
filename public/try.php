<?php
$gvar = "yes";
$f = function () use ($gvar) {
  echo $gvar;
};
$f();
function g()
{
  echo $GLOBALS['gvar'];
}
g();
?>
