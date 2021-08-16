<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->headers->set("Accept", "application/json");
        // $validatedData = $request->validate([
        //     'name' => 'required|max:55',
        //     'email' => 'email|required|string|unique:users',
        //     'password' => 'required|confirmed'
        // ]);
        $data = $request->all();
        $validatedData = Validator::make($data, [
            'name' => 'required|max:55',
            'email' => 'email|required|string|unique:users',
            'password' => 'required|confirmed'
        ]);

        if ($validatedData->fails()) {
            return response(['error' => $validatedData->errors(), "type" => 'Validation Error']);
        }

        $data['password'] = Hash::make($request->password);

        $user = User::create($data);

        $accessToken = $user->createToken('authToken')->accessToken;

        return response(['user' => $user, 'access_token' => $accessToken], 201);
    }

    public function login(Request $request)
    {


        $loginData = $request->validate([
            'email' => 'email|required',
            'password' => 'required'
        ]);

        if (!auth()->attempt($loginData)) {
            return response(['message' => 'Email ou senha inválidos'], 400);
        }

        $accessToken = auth()->user()->createToken('authToken')->accessToken;

        return response(['user' => auth()->user(), 'access_token' => $accessToken]);
    }

    public function logout(Request $request)
    {
        $token = $request->user()->token();
        $token->revoke();
        $response = ['message' => 'Você foi deslogado!'];
        return response($response, 200);
    }
    public function resetPassword(Request $request)
    {
        $this->validate($request, [
            'current_password' => 'required',
            'new_password' => 'required',
            'new_confirm_password' => 'required|same:new_password'
        ]);
        $id =  Auth::user()->id;
        $user = User::findOrFail($id);

        if (Hash::check($request->current_password, $user->password)) {
            $user->password = app('hash')->make($request->new_password);
            $user->save();
        } else {
            return ['password' => 'Confirme sua senha atual corretamente'];
        }

        return ['message' => "Senha alterada com sucesso", 'user' => $user];;
    }
}
