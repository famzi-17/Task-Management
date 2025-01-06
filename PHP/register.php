
<?php
include 'connect.php';
$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$email = $data->email;
$password = password_hash($data->password, PASSWORD_BCRYPT);

$stmt = $conn->prepare("CALL register_user(?, ?, ?)");
$stmt->bind_param("sss", $username, $email, $password);
$stmt->execute();
$result = $stmt->get_result();
$response = $result->fetch_assoc();
echo json_encode($response);
?>
