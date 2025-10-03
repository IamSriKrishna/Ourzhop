import 'package:flutter/material.dart';

class NameDetailsCard extends StatelessWidget {
  final String name;
  final String mobileNumber;
  const NameDetailsCard(
      {super.key, required this.name, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.02,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  radius: size.width * 0.07,
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Text(
                      "${mobileNumber.substring(0, 3)} ${mobileNumber.substring(3)}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        height: 1.2,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
