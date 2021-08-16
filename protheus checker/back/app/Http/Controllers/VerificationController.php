<?php

namespace App\Http\Controllers;

use App\Http\Resources\VerificationResource;
use App\Models\Verification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class VerificationController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $verification = Auth::user()->verifications()->orderBy("created_at", "DESC")->get();
        return response(['verification' => VerificationResource::collection($verification), 'message' => 'Retrieved successfully'], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request) //todo: Criar lógica para os campos last e next_verification
    {
        $data = $request->all();


        $validator = Validator::make($data, [
            'cnpj' => 'required|max:255',
        ]);

        if ($validator->fails()) {
            return response(['error' => $validator->errors(), 'Validation Error']);
        }

        if (Auth::user()->verifications()->Create($data)) {
            return response()->json(['verification' => new VerificationResource($data),'status' => 'success']);
        } else {
            return response()->json(['status' => 'fail']);
        }

        $verification = Verification::create($data);

        return response(['verification' => new VerificationResource($verification), 'message' => 'Created successfully'], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Verification  $verification
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $verification = Verification::find($id);

        return  response()->json($verification);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Verification  $Verification
     * @return \Illuminate\Http\Response
     */
    public function update($id, Request $request, Verification $verification)
    {
        if (Auth::user()->id === $verification->findOrFail($id)->user_id) {
            $verification = $verification::findOrFail($id);
            $verification->update($request->all());
            return response(['verification' => new VerificationResource($verification), 'message' => 'Atualizado com sucesso'], 200);
        } else {
            return response(['message' => 'Erro ao atualizar'], 500);
        }


    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Verification  $Verification
     * @return \Illuminate\Http\Response
     */
    public function destroy($id, Verification $verification)
    {
        if (Auth::user()->id === $verification->findOrFail($id)->user_id) {
            $verification->findOrFail($id)->delete();
            return response(['message' => 'Deleted',], 200);
        } else {
            return response(['message' => 'Erro ao deletar'], 500);
        }
    }
}
