<?php
$conn = new mysqli('localhost', 'check', 'rDEetGxq82DCE', 'check');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM log ORDER BY date DESC LIMIT 1");
$row = $result->fetch_assoc();

echo "Latest Entry: " . $row['text'];

$conn->close();
?>
