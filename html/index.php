<html>
<head>
<title>html page</title>
</head>
<body>
<h1><?php echo "Hello ".($_ENV["NAME"]?$_ENV["NAME"]:"world")."!"; ?></h1>
<?php if($_ENV["HOSTNAME"]) {?><h3>My hostname is <?php echo $_ENV["HOSTNAME"]; ?></h3><?php } ?>
        <?php
        $links = [];
        foreach($_ENV as $key => $value) {
                if(preg_match("/^(.*)_PORT_([0-9]*)_(TCP|UDP)$/", $key, $matches)) {
                        $links[] = [
                                "name" => $matches[1],
                                "port" => $matches[2],
                                "proto" => $matches[3],
                                "value" => $value
                        ];
                }
        }
        ?>

</body>
</html>
