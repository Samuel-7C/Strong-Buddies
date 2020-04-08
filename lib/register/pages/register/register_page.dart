import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strong_buddies_connect/register/pages/register/bloc/register_bloc.dart';
import 'package:strong_buddies_connect/register/pages/register/components/register_password.dart';
import 'package:strong_buddies_connect/routes.dart';
import 'package:strong_buddies_connect/shared/services/auth_service.dart';
import 'package:strong_buddies_connect/shared/services/loader_service.dart';
import 'package:strong_buddies_connect/shared/services/user_collection.dart';
import 'components/register_email.dart';
import 'components/register_gender.dart';
import 'components/register_membership.dart';
import 'components/register_name.dart';
import 'components/register_summary.dart';
import 'components/register_target_gender.dart';
import 'components/register_workout_time.dart';
import 'components/register_workout_type.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = PageController();

  RegisterBloc _bloc;
  List<Widget> _userFields = [];
  Loader loader;

  @override
  void initState() {
    super.initState();
    loader = Loader(context);
    _bloc = RegisterBloc(AuthService(), UserCollection());
    _bloc.add(RegisterEventGetUserInfo());
  }

  void _getUserFieldsBaseOnAuthState(bool wasUserFound) {
    setState(() {
      _userFields = [
        const RegisterEmail(),
        if (!wasUserFound) const RegisterPassword(),
        const RegisterName(),
        const RegisterGender(),
        const RegisterTargetGender(),
        const RegsiterGymMembership(),
        const RegisterWorkoutTime(),
        const RegisterWorkoutType(),
        const RegisterSummary()
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _bloc,
        child: BlocListener<RegisterBloc, RegisterState>(
          condition: (previous, current) =>
              !(current is RegisterDataUpdated) || _userFields.isEmpty,
          listener: (context, state) {
            if (state is RegisterDataUpdated)
              _getUserFieldsBaseOnAuthState(state.userFound);
            else if (state is RegisterInProcess) {
              loader.showLoader();
            } else if (state is RegisterWithError) {
              loader.dismissLoader();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is RegisterSucessful) {
              loader.dismissLoader();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.picturePage, (_) => false);
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color(0xFF4E4C50),
                  width: double.infinity,
                  height: double.infinity,
                  child: Opacity(
                    opacity: 0.50,
                    child: Image.asset(
                      'assets/images/background-login.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: PageView(
                    controller: _controller,
                    children: _userFields,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
