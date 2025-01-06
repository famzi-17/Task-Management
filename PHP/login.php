
<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'connect.php';
$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$password = $data->password;

$stmt = $conn->prepare("CALL check_login(?, ?)");
$stmt->bind_param("ss", $username, $password);
$stmt->execute();
$result = $stmt->get_result();
$response = $result->fetch_assoc();
echo json_encode($response);
?>
