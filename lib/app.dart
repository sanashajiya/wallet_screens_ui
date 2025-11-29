// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_colors.dart';
import 'features/wallet/data/repositories/wallet_repository_impl.dart';
import 'features/wallet/domain/usecases/get_wallet_overview.dart';
import 'features/wallet/domain/usecases/get_payment_screen.dart';
import 'features/wallet/presentation/blocs/wallet_overview/wallet_overview_bloc.dart';
import 'features/wallet/presentation/blocs/wallet_overview/wallet_overview_event.dart';
import 'features/wallet/presentation/blocs/payment/payment_bloc.dart';
import 'features/wallet/presentation/blocs/payment/payment_event.dart';
import 'features/wallet/presentation/pages/wallet_overview_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final walletRepository = WalletRepositoryImpl();
    final getWalletOverview = GetWalletOverview(walletRepository);
    final getPaymentScreen = GetPaymentScreen(walletRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WalletOverviewBloc(
            getWalletOverview: getWalletOverview,
          )..add(const WalletOverviewStarted()),
        ),
        BlocProvider(
          create: (_) => PaymentBloc(
            getPaymentScreen: getPaymentScreen,
          )..add(const PaymentStarted()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallet UI',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.softBackground,
          fontFamily: 'Roboto',
          useMaterial3: false,
        ),
        home: const WalletOverviewPage(),
      ),
    );
  }
}
