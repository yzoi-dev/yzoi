<?php

namespace YZOI\API;

use YZOI\Models\Users;

class UsersApi {
    public static function getAll() {
        return json_encode(Users::findUsersRanks());
    }
}

?>
