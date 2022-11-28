import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum Property {
  name,
  isActive,
  pushNamed,
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const double _iconSize = 15;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.error}')));
        }
      },
      builder: (context, state) {
        final bool isLogged = state is AuthLoaded;
        final double horizontalPadding = MediaQuery.of(context).size.width / 15;
        final List<Map<Property, dynamic>> items = [
          {
            Property.name: AppLocalizations.of(context)!.profile_notice,
            Property.isActive: true,
            Property.pushNamed: Routes.notice,
          },
          {
            Property.name: AppLocalizations.of(context)!.profile_inquiry,
            Property.isActive: true,
            Property.pushNamed: Routes.inquiry,
          },
        ];

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(isLogged ? Routes.myInfo : Routes.login);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: isLogged
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.user.id),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: _iconSize,
                            )
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.profile_login)
                        ],
                      ),
              ),
            ),
            Expanded(
              child: ListView(
                children: items.map(
                  (item) {
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: horizontalPadding,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item[Property.name]),
                            Icon(Icons.arrow_forward_ios, size: _iconSize),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, item[Property.pushNamed]);
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
