
<?php

// put full path to Smarty.class.php
require('/usr/local/lib/php/Smarty/Smarty.class.php');
$smarty = new Smarty();

$smarty->setTemplateDir('/var/www/smarty/templates');
$smarty->setCompileDir('/var/www/smarty/templates_c');
$smarty->setCacheDir('/var/www/smarty/cache');
$smarty->setConfigDir('/var/www/smarty/configs');

$a=(int)$_POST["weight"];

if($a<=2000)
{
  $case=($a>20)+($a>100)+($a>250)+($a>500)+($a>1000);
  switch($case)
  {
  case 0:$prize=7;break;
  case 1:$prize=17;break;
  case 2:$prize=32;break;
  case 3:$prize=62;break;
  case 4:$prize=108;break;
  case 5:$prize=176;break;
  }
  $message="需缴纳 $prize 元的邮资";
} else $message="无法处理信息";

$smarty->assign('message', $message);
$smarty->display('submit.tpl');
?>
