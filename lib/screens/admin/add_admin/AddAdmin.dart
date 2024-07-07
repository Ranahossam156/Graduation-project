import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/RoadModel.dart';
import '../../../models/UserModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';


class AddAdmin extends HookWidget {
  static const String routName="AddRoad";
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final NameController = useTextEditingController();
    final EmailController = useTextEditingController();
    final PasswordController = useTextEditingController();
    final loading = useState(false);
    void handleSubmit() async {
      if (formKey.currentState!.validate()) {
        Result newUser = Result(
          name: NameController.text,
          email: EmailController.text,

          password: PasswordController.text,
          isAdmin: true,
          isPremium: false,
        );

        try {
          await ApiManager.createAdmin(newUser);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created successfully')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create user')));
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
          title: Text('Add New Admin',),
          backgroundColor: Color.fromRGBO(14,46,92,1)
      ),
      body: loading.value
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Form(
        key: formKey,
        child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: 300,

                      decoration: BoxDecoration(
                        color: Color.fromRGBO(14,46,92,1),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Adjust the value as needed
                      )
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png', // Add your image path here
                      width: 280,
                      height: 280,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    CustomTextFormField(
                      textColor:  Color.fromRGBO(14, 46, 92, 1),
                      labelText:'Enter User Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid name';
                        }
                        return null;
                      },
                      controller:NameController,
                      keyboardType: TextInputType.text,

                    ),
                    GradientDivider(),
                    SizedBox(height: 10,)        ,
                    CustomTextFormField(
                      textColor:  Color.fromRGBO(14, 46, 92, 1),
                      labelText:'Enter Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Email';
                        }
                        return null;
                      },
                      controller:EmailController,
                      keyboardType: TextInputType.emailAddress,

                    ),
                    GradientDivider(),
                    SizedBox(height: 10,),
                    CustomTextFormField(
                      textColor:  Color.fromRGBO(14, 46, 92, 1),
                      labelText:'Enter Password',
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                          return 'required, min 5 and max 50.';
                        }
                        return null;
                      },
                      controller:PasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,

                    ),
                    GradientDivider(),
                    SizedBox(height: 50,),

                    MaterialButton(
                      //padding: EdgeInsets.only(left: 50,right: 50),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                      // style: ElevatedButton.styleFrom(
                      color: Color.fromRGBO(14,46,92,1),
                      // shadowColor:Color.fromRGBO(63,190,218,1) ,

                      // borderRadius: BorderRadius.circular(5),// Set the background color here
                      //   ),
                      onPressed: () {
                        handleSubmit();
                      },
                      child: Text('Add',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
          ),
      endDrawer: DrawerScreen(),
    );
  }
}
