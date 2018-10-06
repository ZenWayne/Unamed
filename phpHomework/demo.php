<?php

// put full path to Smarty.class.php
require('/usr/local/lib/php/Smarty/Smarty.class.php');
$smarty = new Smarty();

$smarty->setTemplateDir('/var/www/smarty/templates');
$smarty->setCompileDir('/var/www/smarty/templates_c');
$smarty->setCacheDir('/var/www/smarty/cache');
$smarty->setConfigDir('/var/www/smarty/configs');

//1
$a=13;
$b=15;
if ($a<$b)
    $str='小';
else if ($a>$b)
    $str='大';
else $str='等';
$smarty->assign('str', $str);

//2
$day=date("l");
if($day=='Monday')
    $greet="周一,新的一周开始啦!";
else if($day=='Friday')
    $greet="周五,周末到了,好好休息!";
else if($day=='Sunday')
    $greet="周日,明天又要开始上课了";
else $greet="又是普通的一天";
$smarty->assign('day', $greet);

//4
$i=0;
$str2='';
while($i++<5){
    $str2=$str2."The number is: $i <br>";
}
$i=1;
do{
    $str2=$str2."The number is: $i <br>";
}while(++$i<=5);
for($i=1;$i<=5;$i++)
{
    $str2=$str2."The number is: $i <br>";
}
$smarty->assign('str2',$str2);
//5
$sum=0;
for($i=1;$i<=100;$i++)
{
    $sum+=$i;
}
$smarty->assign('sum',(string)$sum);
//6
$square='';
for($i=0;$i<9;$i++)
{
    for($j=0;$j<9;$j++)
    {
	$square=$square.'* ';
    }
    $square=$square.'<br>';
}
$smarty->assign('square',$square);
//7
$triangle='';
for($i=0;$i<9;$i++)
{
    for($j=0;$j<=$i;$j++)
    {
	$triangle=$triangle.'* ';
    }
    $triangle=$triangle.'<br>';
}
$smarty->assign('triangle',$triangle);
//8
$triangle1='';
for($i=8;$i>=0;$i--)
{
    for($j=0;$j<=$i;$j++)
    {
	$triangle1=$triangle1.'* ';
    }
    $triangle1=$triangle1.'<br>';
}
$smarty->assign('triangle1',$triangle1);
//9
$nine='';
for($i=0;(1<<$i)!=4096;$i++)
    ;
$nine="4096是2的 $i 次方<br>";
$smarty->assign('nine',$nine);

//10
for($i=13,$ten='';$i<=200;$i+=13)
{
    $ten=$ten.(string)$i.' ';
    if($i%5==0)$ten=$ten.'<br>';
}

$smarty->assign('ten',$ten);

//11
for($i=1,$p11=1;$i<=20;$i++)
{
    for($j=1,$product=1;$j<=$i;$j++)
    {
	$product*=$j;
    }
    $p11+=1/$product;
}

$smarty->assign('p11','e='.$p11.'<br>');

//12

for($i=1,$p12='';$i<=100;$i++)
{
    if($i%10)continue;
    $p12=$p12."您是第 $i 位留言给我的朋友<br>";
}

$smarty->assign('p12',$p12);

//13
include 'include.php';
$smarty->assign('p13',$p13);

//14
include 'area.php';
$p14=(string)include0($width,$height).'<br>';
$smarty->assign('p14',$p14);

$smarty->display('demo.tpl');
?>
