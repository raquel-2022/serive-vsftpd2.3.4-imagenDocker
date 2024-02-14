<?php

error_reporting(E_ERROR | E_PARSE); 
ini_set('display_errors', 0);  

//echo "Ruta actual: " . getcwd();  
$target_dir = "uploads/";
//echo "Ruta de destino: " . realpath($target_dir);  // Imprime la ruta completa del directorio "uploads"
//error_reporting(E_ALL);
//ini_set('display_errors', 1);
//var_dump($_FILES);

$target_dir = "uploads/";
$target_file = $target_dir . ' -> ' . basename($_FILES["file"]["name"]);
$uploadOk = 1;
// Agregar echo para imprimir la ruta de destino
//echo "Ruta de destino: $target_file";

$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));


// Verifica si el archivo ya existe
if (file_exists($target_file)) {
    echo "El archivo ya existe.";
    $uploadOk = 0;
}

// Limita el tama l archivo (poejemplo, 5 M)
if ($_FILES["file"]["size"] > 5000000) {
    echo "El archivo es demasiado grande.";
    $uploadOk = 0;
}

// Permitir solo ciertos tipos de archivos 
$imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
//if($imageFileType != "txt" && $imageFileType != "pdf" && $imageFileType != "doc") {
//    echo "Solo se permiten archivos de texto, PDF y documentos.";
//    $uploadOk = 0;
//}
// Antes de intentar mover el archivo, verifica si el directorio existe
if (!file_exists($target_dir)) {
    mkdir($target_dir, 0777, true);
}

if ($uploadOk == 0) {
    echo "   El archivo no fue subido.";
// Si todo est bien, intenta subir el archivo
} else {
    if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
        echo "El archivo ". htmlspecialchars( basename( $_FILES["file"]["name"])). " ha sido subido.";
    } else {
        echo "Hubo un error al subir el archivo.";
    }
}
?>


