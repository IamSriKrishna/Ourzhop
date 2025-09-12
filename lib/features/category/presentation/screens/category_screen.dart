import 'package:customer_app/features/category/presentation/widgets/category_widgets.dart';
import 'package:customer_app/features/home/domain/usecase/category_usecase.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return BlocProvider(
      create: (_) => CategoryBloc(
        getCategories: serviceLocator<GetCategoriesUseCase>(),
      )..add(GetCategoriesEvent(limit: null, cursor: null)),
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        body: Column(
          children: [
            CustomAppBar(context: context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'All Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CategoriesGrid(context: context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
