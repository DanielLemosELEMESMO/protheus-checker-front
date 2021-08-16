<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Verification extends Model
{
    use HasFactory;

    protected $fillable = [
        'email',
        'cnpj',
        'query_sql',
        'frequency',
        'user_id',
        "corporate_name"
    ];

    protected $guarded = [
        "next_verification",
        "last_verification",
    ];
}
