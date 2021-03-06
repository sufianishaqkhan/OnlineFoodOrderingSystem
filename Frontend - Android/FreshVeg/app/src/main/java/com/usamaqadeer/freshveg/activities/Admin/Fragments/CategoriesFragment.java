package com.usamaqadeer.freshveg.activities.Admin.Fragments;

import android.app.Dialog;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.usamaqadeer.freshveg.R;
import com.usamaqadeer.freshveg.activities.Admin.Adapters.CategoriesAdapter;
import com.usamaqadeer.freshveg.api.models.CategoriesModel;
import com.usamaqadeer.freshveg.api.rest.RestAPI;
import com.usamaqadeer.freshveg.api.rest.RestClient;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class CategoriesFragment extends Fragment {
    private RecyclerView recyclerView;
    private CategoriesAdapter adapter;
    private FloatingActionButton fabAddCategory;
    private EditText etName;
    private Button btnAdd, btnCancel;

    public CategoriesFragment() { }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_categories, container, false);

        recyclerView = view.findViewById(R.id.recyclerView);
        fabAddCategory = view.findViewById(R.id.fab_add_cat);

        initDialogView(view);
        getCategoriesData();

        fabAddCategory.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addCategoryDialog();
            }
        });

        return view;
    }

    /*GET CATEGORIES API CALL*/
    private void getCategoriesData(){
        RestAPI service = RestClient.getRetrofitInstance().create(RestAPI.class);
        Call<List<CategoriesModel>> call = service.getCategories();
        call.enqueue(new Callback<List<CategoriesModel>>() {
            @Override
            public void onResponse(Call<List<CategoriesModel>> call, Response<List<CategoriesModel>> response) {
                if (response.body().isEmpty())
                    Toast.makeText(getContext(), "Unable to retrieve categories list.", Toast.LENGTH_SHORT).show();
                else
                    loadCategoriesData(response.body());
            }

            @Override
            public void onFailure(Call<List<CategoriesModel>> call, Throwable t) {
                Toast.makeText(getContext(), "Failed to contact server. Please try again later.", Toast.LENGTH_SHORT).show();
            }
        });
    }

    /*LOAD CATEGORIES LIST IN RECYCLER VIEW USING ADAPTER*/
    private void loadCategoriesData(List<CategoriesModel> categoriesList) {
        adapter = new CategoriesAdapter(getContext(), categoriesList);
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(getContext());
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(adapter);
    }

    /*SHOW ADD CATEGORY DIALOG*/
    public void addCategoryDialog() {
        final Dialog dialog = new Dialog(getContext());
        dialog.setContentView(R.layout.add_category_layout);
        initAddDeliveryBoyDialog(dialog);

        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (etName.getText().toString().isEmpty() == true) {
                    Toast.makeText(getContext(), "Field cannot be empty.", Toast.LENGTH_SHORT).show();
                }
                else {
                    addCategory(etName.getText().toString());
                    dialog.dismiss();
                }
            }
        });
        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });

        dialog.show();

        DisplayMetrics metrics = getResources().getDisplayMetrics();
        int width = metrics.widthPixels;
        int height = metrics.heightPixels;
        dialog.getWindow().setLayout((6 * width)/7, (2 * height)/5);
    }

    private void initAddDeliveryBoyDialog(Dialog dialog) {
        etName = dialog.findViewById(R.id.et_name);
        btnAdd = dialog.findViewById(R.id.btn_add_db);
        btnCancel = dialog.findViewById(R.id.btn_cancel);
    }

    private void initDialogView(View view) {
        etName = view.findViewById(R.id.et_name);
        btnAdd = view.findViewById(R.id.btn_add_db);
        btnCancel = view.findViewById(R.id.btn_cancel);
    }

    /*ADD CATEGORY API CALL*/
    private void addCategory(String name){
        RestAPI service = RestClient.getRetrofitInstance().create(RestAPI.class);
        Call<String> call = service.postCategory(name);
        call.enqueue(new Callback<String>() {
            @Override
            public void onResponse(Call<String> call, Response<String> response) {
                if (response.body().equals("false"))
                    Toast.makeText(getContext(), "Failed to add category. Please try again later.", Toast.LENGTH_SHORT).show();
                else if (response.body().equals("true")){
                    Toast.makeText(getContext(), "Category added successfully.", Toast.LENGTH_SHORT).show();
                    getCategoriesData();
                }
            }

            @Override
            public void onFailure(Call<String> call, Throwable t) {
                Toast.makeText(getContext(), "Failed to contact server. Please try again later.", Toast.LENGTH_SHORT).show();
            }
        });
    }
}