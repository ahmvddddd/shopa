import 'package:flutter/material.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../utils/constants/sizes.dart';

class AccountMenu extends StatefulWidget {
  const AccountMenu({super.key});

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  final List<Map<String, dynamic>> settingsList = [
    {"title": "Security", "subtitle": "Change your Password"},
    {"title": "Saved Cards", "subtitle": ""},
    {"title": "Help", "subtitle": "Talk to customer service"},
    {"title": "Report An Issue", "subtitle": ""},
  ];
  @override
  Widget build(BuildContext context) {
    return HomeListView(
      scrollDirection: Axis.vertical,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      seperatorBuilder: (context, index) => const SizedBox(height: Sizes.sm),
      itemCount: settingsList.length,
      itemBuilder: (context, index) {
        return SettingsMenuTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'No saved info',
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Unable to find your info',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: Sizes.sm),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Close',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Colors.red[900]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icons.circle,
          title: settingsList[index]["title"],
          subTitle: settingsList[index]["subtitle"],
          trailing: const Icon(Icons.arrow_right, size: Sizes.iconMd),
        );
      },
    );
  }
}
