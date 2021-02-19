package com.example.upesaio;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class CampusPage extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.campus_page);
    }
    public void  bidhobot(View view)
    {
        Intent intent1 =new Intent(this,Bhidholi.class);
        startActivity(intent1);
    }
    public void kandbot(View view)
    {
        Intent intent2=new Intent(this,Kandoli.class);
        startActivity(intent2);
    }

}