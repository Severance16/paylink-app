import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/features/recharge/domain/entities/entities.dart';
import 'package:technical_test/features/recharge/presentation/providers/suppliers_provider.dart';

class RechargeResumeScreen extends ConsumerWidget {
  static const name = 'resume';
  final border = Radius.circular(10);
  final Ticket ticket;
  RechargeResumeScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliers = ref.watch(suppliersProvider).suppliers;
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
        title: const Text('Resumen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: border,
              bottomRight: border,
              topLeft: border,
            ),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 60, color: Colors.green),
                const SizedBox(height: 12),
                Text(
                  "Transacción Exitosa",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                _buildDetailRow("Mensage:", ticket.message),
                _buildDetailRow("ID Transacción:", ticket.transactionalId),
                _buildDetailRow("Proveedor:", suppliers.firstWhere((supplier) => supplier.id == ticket.supplierId).name),
                _buildDetailRow("Teléfono:", ticket.cellPhone),
                _buildDetailRow("Valor:", "\$ ${ticket.value}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
