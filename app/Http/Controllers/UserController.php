<?php

namespace App\Http\Controllers;
use App\Models\users;
use Illuminate\Http\Request;

class UserController
{
    //users list
    public function users()
    {
        $abcd = users::all();
        return $abcd;
         
    }
}
