<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\VerificationController;
use App\Http\Resources\VerificationResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('user', [UserController::class, 'store']);
Route::get('user', [UserController::class, 'index']);
Route::put('user', [UserController::class, 'update']);
Route::delete('user', [UserController::class, 'destroy']);
Route::get('me', [UserController::class, 'me'])->middleware('auth:api');

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::post('/reset-password', [AuthController::class, 'resetPassword'])->middleware('auth:api');
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:api');

Route::post('verification', [VerificationController::class, 'store'])->middleware('auth:api');
Route::get('verification', [VerificationController::class, 'index'])->middleware('auth:api');
Route::get('verification/{id}', [VerificationController::class, 'show'])->middleware('auth:api');
Route::put('verification/{id}', [VerificationController::class, 'update'])->middleware('auth:api');
Route::delete('verification/{id}', [VerificationController::class, 'destroy'])->middleware('auth:api');
