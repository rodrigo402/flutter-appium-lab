import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_semantics.dart';
import 'package:appium_flutter_demo/features/items/domain/item_model.dart';

const mockItems = [
  ItemModel(
    id: '1',
    title: 'Transferencia a Juan',
    subtitle: 'Pendiente · \$1.500',
    description:
        'Transferencia programada a Juan Pérez por servicios de consultoría.',
    amount: 1500,
  ),
  ItemModel(
    id: '2',
    title: 'Pago de alquiler',
    subtitle: 'Completada · \$85.000',
    description: 'Pago mensual de alquiler correspondiente a mayo.',
    amount: 85000,
  ),
  ItemModel(
    id: '3',
    title: 'Reembolso compra',
    subtitle: 'En revisión · \$3.200',
    description: 'Solicitud de reembolso por compra duplicada en tienda online.',
    amount: 3200,
  ),
];

/// Maps each mock item to its Appium key.
const itemCardKeys = [
  AppKeys.itemCard1,
  AppKeys.itemCard2,
  AppKeys.itemCard3,
];

/// Maps each mock item to its accessibility label.
const itemCardSemantics = [
  AppSemantics.itemCard1,
  AppSemantics.itemCard2,
  AppSemantics.itemCard3,
];
