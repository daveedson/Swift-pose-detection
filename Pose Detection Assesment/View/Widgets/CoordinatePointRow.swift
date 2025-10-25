//
//  CoordinatePointRow.swift
//  Pose Detection Assesment
//
//  Created by DavidOnoh on 10/25/25.
//

import SwiftUI

struct CoordinatePointRow: View {
    let point: CoordinatePoint

    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 10, height: 10)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("X")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        Text(String(format: "%.3f", point.x))
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }

                    HStack(spacing: 4) {
                        Text("Y")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        Text(String(format: "%.3f", point.y))
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }

                    Spacer()
                }

                Text(timeString(from: point.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(8)
    }

    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}

