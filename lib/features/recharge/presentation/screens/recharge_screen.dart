import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/recharge/domain/domain.dart';
import 'package:technical_test/features/recharge/presentation/providers/data_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/detail_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/recharge_form_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/suppliers_provider.dart';
import 'package:technical_test/features/shared/shared.dart';
import 'package:technical_test/features/shared/widgets/custom_drop_button_form_field.dart';

class RechargeScreen extends StatelessWidget {
  static const name = 'recharge';
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Recargas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _FormRecharge(),
            const SizedBox(height: 20),
            Expanded(child: HistoryRecharges()),
          ],
        ),
      ),
    );
  }
}

class _FormRecharge extends ConsumerWidget {
  const _FormRecharge();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rechargeForm = ref.watch(rechargeFormProvider);
    final suppliers = ref.watch(suppliersProvider);

    final List<Supplier> options = suppliers.suppliers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropButtonFormField(
              validator: (e) => e == null ? 'Selecciona un valor' : null,
              items: options,
              errorMessage:
                  rechargeForm.isFormPosted
                      ? rechargeForm.supplier.errorMessage
                      : null,
              label: 'Seleccionar opción',
              onChanged: (val) {
                if (val != null) {
                  Supplier selected = options.firstWhere((e) => e.id == val);
                  if (selected.id.isNotEmpty) {
                    ref
                        .read(rechargeFormProvider.notifier)
                        .onSupplierChange(selected);
                  }
                }
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Número de teléfono',
              obscureText: false,
              onChanged: ref.read(rechargeFormProvider.notifier).onPhoneChange,
              errorMessage:
                  rechargeForm.isFormPosted
                      ? rechargeForm.phone.errorMessage
                      : null,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Valor',
              obscureText: false,
              onChanged: ref.read(rechargeFormProvider.notifier).onValueChange,
              errorMessage:
                  rechargeForm.isFormPosted
                      ? rechargeForm.value.errorMessage
                      : null,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Generar recarga',
                buttonColor: Color.fromRGBO(34, 40, 49, 1),
                onPressed:
                    rechargeForm.isPosting
                        ? null
                        : () async {
                          final result =
                              await ref
                                  .read(rechargeFormProvider.notifier)
                                  .onFormSubmit();
                          if (result != null && context.mounted) {
                            context.push('/resume', extra: result);
                          }
                        },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryRecharges extends ConsumerWidget {
  const HistoryRecharges({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider);
    final suppliers = ref.watch(suppliersProvider);

    if (data.isLoading || suppliers.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<Ticket> historyData = data.history;
    if (historyData.isEmpty) {
      return const Center(child: Text("No hay datos disponibles"));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 15,
        headingRowHeight: 50,
        columns: const [
          DataColumn(label: Text('Numero')),
          DataColumn(label: Text('Valor')),
          DataColumn(label: Text('Operador')),
        ],
        rows:
            historyData.map((data) {
              return DataRow(
                cells: [
                  DataCell(
                    ClickableTextCell(
                      text: data.cellPhone,
                      extra: data.id,
                    ),
                  ),
                  DataCell(
                     ClickableTextCell(
                      text: data.value.toString(),
                      extra: data.id,
                    ),
                  ),
                  DataCell(
                    ClickableTextCell(
                      text: suppliers.suppliers.firstWhere((supplier) => supplier.id == data.supplierId).name,
                      extra: data.id,
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}

class ClickableTextCell extends ConsumerWidget  {
  final String text;
  final String route;
  final int extra;

  const ClickableTextCell({
    super.key,
    required this.text,
    this.route = "/detail",
    required this.extra,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await ref.read(detailProvider.notifier).getTicketById(extra);
        
        if (context.mounted) {
          context.push(route, extra: extra);
        }

      },
      child: Center(child: Text(text)),
    );
  }
}
